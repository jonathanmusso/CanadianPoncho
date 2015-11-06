class VehiclePolicy < ApplicationPolicy
    def re_edit?
        update?
    end

    def resubmit?
        update?
    end
end