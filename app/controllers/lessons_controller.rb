class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user_enrollment, only: [:show]
  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
  def require_user_enrollment
    if current_user.enrolled_in?(current_lesson.section.course)
      #render plain: "Unauthorized", status: :unauthorized
      #do nothing; continue to view
    else
      redirect_to course_path(current_lesson.section.course), alert: 'You are not enrolled in this course. Please enroll to access.' 
    end
  end
end
