class Api::V1::ResidentsController < ApplicationController
  def create
    resident = Resident.new(resident_params)

    if resident.save
      render json: resident, status: :ok
    else
      render json: { errors: resident.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def resident_params
    params.require(:resident)
          .permit(
            :first_name, :middle_name, :last_name, :date_of_birth, :gender,
            contact_detail_attributes:,
            emergency_contact_attributes:,
            stay_detail_attributes:,
            proof_of_id_attributes:,
            payments_attributes:
          )
  end

  def contact_detail_attributes
    %i[ email mobile_number ]
  end

  def emergency_contact_attributes
    %i[ name relationship email mobile_number ]
  end

  def stay_detail_attributes
    %i[ move_in_date duration_of_stay special_requirements ]
  end

  def payments_attributes
    %i[ unitary_amount method transaction_id transaction_date reason ]
  end

  def proof_of_id_attributes
    %i[ identifier_type identifier_value ]
  end
end
