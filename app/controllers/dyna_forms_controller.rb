class DynaFormsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: :index
  # login_url
  def new
  end

  def details
    @dyna_form = Current.user.dyna_forms.find(params[:id])
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "user_#{Current.user.id}_dyna_form_window",
          partial: "dyna_forms/dyna_form_with_inputs",
          locals: {dyna_form: @dyna_form}
        )}
    end
  end

  def create
    @dyna_form = Current.user.dyna_forms.create(dyna_form_params)
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
    dyna_form = Current.user.dyna_forms.find(params[:id])
    dyna_form.destroy
  end

  private
  def dyna_form_params
    params.require(:dyna_form).permit(:title, :description)
  end
end