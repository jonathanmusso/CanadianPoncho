module VehiclesHelper
  def display_chosen_check_box_tag(current_option, selected, parameter_name)
    if selected.to_a.include?(current_option)
      check_box_tag parameter_name, current_option, checked: "checked"
    else
      check_box_tag parameter_name, current_option
    end
  end
end
