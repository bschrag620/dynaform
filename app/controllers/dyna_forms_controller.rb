class DynaFormsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: :index
  before_action :set_dyna_form, except: :index
  # login_url
  def new
  end

  def details
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "user_#{Current.user.id}_dyna_form_window",
          partial: "dyna_forms/dyna_form_with_inputs",
          locals: {dyna_form: @dyna_form}
        )}
    end
  end

  def publish
    updateable = @dyna_form.form_inputs.any? && !@dyna_form.published
    respond_to do |format|
      format.turbo_stream do
        if updateable && @dyna_form.publish
          render turbo_stream: turbo_stream.replace(
            "session_#{Current.session.id}",
            target: "flash_message",
            partial: "flash_message",
            locals: {message: "#{@dyna_form.title} has been published!", status: "success"}
          )
        else
          render turbo_stream: turbo_stream.replace(
            "session_#{Current.session.id}",
            target: "flash_message",
            partial: "flash_message",
            locals: {message: "#{@dyna_form.title} cannot be published.", status: "error"}
          )
        end
      end
    end
  end

  def unpublish
    if @dyna_form.unpublish
      render turbo_stream: turbo_stream.replace(
        "session_#{Current.session.id}",
        target: "flash_message",
        partial: "flash_message",
        locals: {message: "#{@dyna_form.title} has been unpublished.", status: "success"}
      )
    else
      render turbo_stream: turbo_stream.replace(
        "session_#{Current.session.id}",
        target: "flash_message",
        partial: "flash_message",
        locals: {message: "#{@dyna_form.title} cannot be unpublished", status: "error"}
      )
    end
  end

  def create
    respond_to do |format|
      if @dyna_form.save
        format.turbo_stream {render layout: false}
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            @dyna_form,
            partial: "dyna_forms/form",
            locals: {dyna_form: @dyna_form}
          )}
      end
    end
  end

  def destroy
    dyna_form.destroy
  end

  private
  def dyna_form_params
    params.require(:dyna_form).permit(:title, :description)
  end

  def set_dyna_form
    @dyna_form = Current.user.dyna_forms.find(params[:id])
  end
end