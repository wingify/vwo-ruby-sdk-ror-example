class HomeController < ApplicationController
  USERS = %w(Ashley Bill Chris Dominic Emma Faizan Gimmy Harry Ian John King Lisa Mona Nina Olivia Pete Queen Robert Sarah Tierra Una Varun Will Xin You Zeba)

  def index;end

  def basic_example
    vwo_client_instance = VWOService.get_vwo_instance
    run_example(vwo_client_instance)
  end

  def user_defined_logger_example
    vwo_client_instance = VWOService.get_vwo_instance
    VWOService.start_logger
    run_example(vwo_client_instance)
    VWOService.stop_logger
  end

  def user_storage_example
    vwo_client_instance = VWOService.get_vwo_user_storage_instance
    run_example(vwo_client_instance)
  end

  private

  def run_example(vwo_client_instance)
    ab_campaign_key = params['ab_campaign_key']
    user_id = params['userId'] || USERS.sample
    revenue_value = params['revenue'].to_i
    ab_campaign_goal_identifier = params['ab_campaign_goal_identifier']

    variation_name = vwo_client_instance.activate(ab_campaign_key, user_id)
    vwo_client_instance.track(ab_campaign_key, user_id, ab_campaign_goal_identifier, revenue_value)

    render :example, locals: {
      part_of_campaign: variation_name.nil? ? 'No' : 'Yes',
      variation_name: variation_name,
      settings_file: vwo_client_instance.get_settings,
      ab_campaign_key: ab_campaign_key,
      ab_campaign_goal_identifier: ab_campaign_goal_identifier,
      user_id: user_id
    }
  end
end
