class CalculadorasController < ApplicationController
  respond_to :json, :html
  
  def show
  end
  
  def operar
    resultado = {}
    op1 = params[:op1].to_f
    op2 = params[:op2].to_f
    
    case params[:op]
      when '+'
        resultado["res"] = op1 + op2
      when '-'
        resultado["res"] = op1 - op2
      when '*'
        resultado["res"] = op1 * op2
      when '/'
        resultado["res"] = op1 / op2
    end
    
    respond_to do |format|
      format.json {render json: resultado}
    end
  end
end
