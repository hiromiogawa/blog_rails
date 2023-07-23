class GraphqlController < ApplicationController

  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: authorize
    }
    result = BlogRailsSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  # ログイン認証
  def authorize
    token = request.headers[:HTTP_AUTHORIZATION]&.split('Bearer ')&.last
    return unless token

    decoded_token = JwtHelper.decode(token)
    return unless decoded_token

    decoded_token = JwtHelper.decode(token)
    user_id = decoded_token['user_id']
    User.find_by(id: user_id)
  rescue JWT::DecodeError
    nil
  end
end
