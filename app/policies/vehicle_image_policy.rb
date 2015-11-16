class VehicleImagePolicy < ApplicationPolicy
    def update?
      user.present? && (record.vehicle.user == user || user.admin?)
    end

    def destroy?
      user.present? && (record.vehicle.user == user || user.admin?)
    end
end
