class DynaFormsController < ApplicationController
  # login_url
  def new
  end

  def create
    @dyna_form = Current.user.dyna_forms.create(dyna_form_params)
    respond_to do |format|
      if @dyna_form.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "new_dyna_form",
            partial: "dyna_forms/form",
            locals: {dyna_form: @dyna_form}
          )
        }
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