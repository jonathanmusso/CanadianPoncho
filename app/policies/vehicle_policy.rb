class VehiclePolicy < ApplicationPolicy
  def re_edit?
    true
  end
  def resubmit?
    true
  end
end