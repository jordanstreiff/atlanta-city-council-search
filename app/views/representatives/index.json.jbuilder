json.npu @npu
if @council_member
  json.extract! @council_member, :id, :district_id, :full_name, :email, :phone_number, :website
else
  json.district_id 0
end