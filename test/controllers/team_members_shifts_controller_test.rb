require 'test_helper'

class TeamMembersShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team_members_shift = team_members_shifts(:one)
  end

  test "should get index" do
    get team_members_shifts_url
    assert_response :success
  end

  test "should get new" do
    get new_team_members_shift_url
    assert_response :success
  end

  test "should create team_members_shift" do
    assert_difference('TeamMembersShift.count') do
      post team_members_shifts_url, params: { team_members_shift: { paid_date: @team_members_shift.paid_date, shift_date: @team_members_shift.shift_date, shift_hrs: @team_members_shift.shift_hrs, team_member_id: @team_members_shift.team_member_id } }
    end

    assert_redirected_to team_members_shift_url(TeamMembersShift.last)
  end

  test "should show team_members_shift" do
    get team_members_shift_url(@team_members_shift)
    assert_response :success
  end

  test "should get edit" do
    get edit_team_members_shift_url(@team_members_shift)
    assert_response :success
  end

  test "should update team_members_shift" do
    patch team_members_shift_url(@team_members_shift), params: { team_members_shift: { paid_date: @team_members_shift.paid_date, shift_date: @team_members_shift.shift_date, shift_hrs: @team_members_shift.shift_hrs, team_member_id: @team_members_shift.team_member_id } }
    assert_redirected_to team_members_shift_url(@team_members_shift)
  end

  test "should destroy team_members_shift" do
    assert_difference('TeamMembersShift.count', -1) do
      delete team_members_shift_url(@team_members_shift)
    end

    assert_redirected_to team_members_shifts_url
  end
end
