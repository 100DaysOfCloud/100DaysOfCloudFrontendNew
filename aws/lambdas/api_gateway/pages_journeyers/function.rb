require 'json'

def handler(event:, context:)
  client = Aws::DynamoDB::Client.new(
    region: region_name,
    credentials: credentials
  )
  resp = client.query({
    table_name: 'Journeyers',
    select: 'ALL_ATTRIBUTES',
    limit: 100,
    consistent_read: false
    request_items: {
      "Journeyers" => {
        keys: [
          { "MyKey" => "MyValue" }
        ]
      }
    },
    consistent_read: true
  })
end
