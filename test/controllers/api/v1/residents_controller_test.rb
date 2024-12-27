require "test_helper"

class Api::V1::ResidentControllerTest < ActionDispatch::IntegrationTest
  test "creates a resident record" do
    assert_difference "Resident.count", 1 do
      assert_difference "ContactDetail.count", 1 do
        assert_difference "EmergencyContact.count", 1 do
          assert_difference "StayDetail.count", 1 do
            assert_difference "Payment.count", 2 do
              assert_difference "ProofOfId.count", 1 do
                post "/api/v1/residents", params: valid_params
              end
            end
          end
        end
      end
    end

    response_body = JSON.parse(response.body)

    assert_response :success
    assert response_body["first_name"], "Jane"
    assert_equal "Earl", response_body["middle_name"]
    assert_equal "Doe", response_body["last_name"]
    assert_equal "1995-05-25", response_body["date_of_birth"]
    assert_equal "female", response_body["gender"]
  end

  private

  def valid_params
    {
      resident: {
        first_name: "Jane",
        middle_name: "Earl",
        last_name: "Doe",
        date_of_birth: "1995-05-25",
        gender: "female",
        contact_detail_attributes: {
          email: "jane.doe@example.com",
          mobile_number: "1234567890"
        },
        emergency_contact_attributes: {
          name: "Shirley Ann",
          relationship: "Cousin",
          email: "shirley.anne@example.com",
          mobile_number: "1234567890"
        },
        stay_detail_attributes: {
          move_in_date: "2024-01-01",
          duration_of_stay: "Full Year",
          special_requirements: "None"
        },
        proof_of_id_attributes: {
          identifier_type: "passport",
          identifier_value: "PASS-1234"
        },
        payments_attributes: [
          {
            unitary_amount: "550000",
            method: "Bank Transfer",
            transaction_id: "BACS1234",
            transaction_date: "05/05/1989",
            reason: "Rent"
          },
          {
            unitary_amount: "198009",
            method: "Bank Transfer",
            transaction_id: "MOMO-0505",
            transaction_date: "25/04/2000",
            reason: "Misc. Fees"
          }
        ]
      }
    }
  end
end
