const aws = require('aws-sdk')
const dynamodb = new aws.DynamoDB({apiVersion: '2012-10-08'})

exports.handler = async (event, context) => {
  const date       = new Date()
  const table_name = process.env.TABLE_NAME
  const region     = process.env.REGION

  aws.config.update({region: region})

  // Nothing to do, the user's email ID is unknown
  if (!event.request.userAttributes.sub) {
    console.log("error:request", "Nothing was written to DDB or SQS")
    return context.done(null, event)
  }

  const params = {
    TableName: table_name,
    Item: {
      'id'        : {S: event.request.userAttributes.sub},
      '__typename': {S: 'User'},
      'username'  : {S: event.userName},
      'email'     : {S: event.request.userAttributes.email},
      'createdAt' : {S: date.toISOString()}
    }
  }

  try {
    await dynamodb.putItem(params).promise()
  } catch (err) {
    console.log("error:putItem", err)
  }
  context.done(null, event)
}

