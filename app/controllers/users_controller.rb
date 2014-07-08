class UsersController < ApplicationController
  def edit
  end

  def upload_bracket
    uploaded_io = params[:bracket]

    if uploaded_io.present? && uploaded_io.is_a?(ActionDispatch::Http::UploadedFile)
      File.open(Rails.root.join('public', 'uploads', "#{current_user.email.parameterize}.csv"), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      current_user.save_bracket

      redirect_to bracket_path(current_user), flash: { success: "Your bracket predictions have been added successfully." }
    else
      redirect_to edit_user_path(current_user), flash: { error: "No .csv file found. Please try again." }
    end
  end
end
