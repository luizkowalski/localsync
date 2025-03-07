require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should render a json list of entries" do
    get space_entries_url(spaces(:synced).contentful_id)

    assert_response :success
    assert_equal "application/json; charset=utf-8", response.content_type
  end

  test "entries should conform to the expected schema" do
    entry = entries(:entry)
    space = spaces(:synced)

    get space_entries_url(space.contentful_id)

    assert_response :success

    json = JSON.parse(response.body)


    id           = json.dig("items", 0, "sys", "id")
    space_id     = json.dig("items", 0, "sys", "space", "sys", "id")
    environment  = json.dig("items", 0, "sys", "environment", "sys", "id")
    content_type = json.dig("items", 0, "sys", "contentType", "sys", "id")

    assert_equal entry.space.contentful_id, space_id
    assert_equal entry.environment.contentful_id, environment
    assert_equal entry.content_type_id, content_type
    assert_equal entry.contentful_id, id
  end
end
