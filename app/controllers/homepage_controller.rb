require 'csv'

class HomepageController < ApplicationController

	def index
		@errors = Array.wrap(session[:errors])
		session.delete(:errors) if session[:errors].present?
		@users = User.all
	end

	def upload_csv
		@errors = []
		if params[:csv_file].present?
			data = CSV.parse(File.read(params[:csv_file]))
			data.each do |arr|
				next if arr == data.first
				user = User.find_by(name: arr[0])
				user = User.new(name: arr[0]) if user.blank?
				user.password = arr[1]
				if user.save
					@errors << "#{user.name} was successfully saved"
				else
					@errors << user.errors.full_messages.last
				end
			end
		end
		session[:errors] = @errors
		redirect_to root_path
	end
end
