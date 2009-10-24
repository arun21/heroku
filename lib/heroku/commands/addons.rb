module Heroku::Command
	class Addons < BaseWithApp
		def index
			installed = heroku.installed_addons(app)
			if installed.empty?
				display "No addons installed"
			else
				available, pending = installed.partition { |a| a['configured'] }
				available.map { |a| a['name'] }.sort.each do |addon|
					display addon
				end
				unless pending.empty?
					display "\n--- not configured ---"
					pending.map { |a| a['name'] }.sort.each do |addon|
						display addon.ljust(24) + "http://#{heroku.host}/myapps/#{app}/addons/#{addon}"
					end
				end
			end
		end

		def info
			addons = heroku.addons
			if addons.empty?
				display "No addons available currently"
			else
				available, beta = addons.partition { |a| !a['beta'] }
				display_addons(available)
				if !beta.empty?
					display "\n--- beta ---"
					display_addons(beta)
				end
			end
		end

		def add
			addon = args.shift
			config = {}
			args.each do |arg|
				key, value = arg.strip.split('=', 2)
				if value.nil?
					addon_error("Non-config value \"#{arg}\".  Everything after the addon name should be a key=value pair.")
					exit 1
				else
					config[key] = value
				end
			end

			display "Adding #{addon} to #{app}... ", false
			display addon_run { heroku.install_addon(app, addon, config) }
		end

		def remove
			args.each do |name|
				display "Removing #{name} from #{app}... ", false
				display addon_run { heroku.uninstall_addon(app, name) }
			end
		end

		def clear
			heroku.installed_addons(app).each do |addon|
				display "Removing #{addon['description']} from #{app}... ", false
				display addon_run { heroku.uninstall_addon(app, addon['name']) }
			end
		end

		def confirm_billing
			display("This action will cause your account to be billed at the end of the month")
			display("Are you sure you want to do this? (y/n) ", false)
			if ask.downcase == 'y'
				heroku.confirm_billing
				return true
			end
		end

		private
			def display_addons(addons)
				grouped = addons.inject({}) do |base, addon|
					group, short = addon['name'].split(':')
					base[group] ||= []
					base[group] << addon.merge('short' => short)
					base
				end
				grouped.keys.sort.each do |name|
					addons = grouped[name]
					row = name.dup
					if addons.any? { |a| a['short'] }
						row << ':'
						size = row.size
						stop = false
						row << addons.map { |a| a['short'] }.sort.map do |short|
							size += short.size
							if size < 31
								short
							else
								stop = true
								nil
							end
						end.compact.join(', ')
						row << '...' if stop
					end
					display row.ljust(34) + (addons.first['url'] || '')
				end
			end

			def addon_run
				yield
				'done'
			rescue RestClient::ResourceNotFound => e
				addon_error("no addon by that name")
			rescue RestClient::RequestFailed => e
				if e.http_code == 402
					confirm_billing ? retry : 'canceled'
				else
					error = Heroku::Command.extract_error(e.http_body)
					addon_error(error)
				end
			end

			def addon_error(message)
				"FAILED\n" + message.split("\n").map { |line| ' !   ' + line }.join("\n")
			end
	end
end
