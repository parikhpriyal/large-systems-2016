var ddb = require('dynamodb').ddb({ accessKeyId: 'AKIAJHDLRGR7HM2CURLA',
                                    secretAccessKey: '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',
                                    endpoint: "dynamodb.us-east-1.amazonaws.com" });
var express = require('express');
var app = express();
var port = 7000;
var url = '149.31.125.159';
var server = app.listen(port);
var io = require('socket.io').listen(server);

app.use(express.static(__dirname + '/'));
console.log('Simple static server listening at '+url+':'+port);

app.get('', function (req, res) {
  res.setHeader('Content-Type', 'text/plain; charset=utf-8')
  res.end('YOUR SERVER IS RUNNING')
 });

io.sockets.on('connection', function(socket){
	console.log("socket on");
	socket.on('toDDB', function(data){
		console.log(data);
		ddb.putItem({
			"TableName" : "BedsideWhisper",
			"Item":{
				"girl": data.lastUserMessage
			}, function(err, response){
				console.log('sent to database');		
			}
		});
		
			// 'BedsideWhisper', {girlmessage: data}, function(err, response){
			// console.log('entry made');
		
		// ddb.putItem('BedsideWhisper', data, {},
			
		// 	function(err, dynamoResult, cap){
		// 		res.send({"girl": newData.lastUserMessage})
		// 		console.log('sent to database');
		// });
	});
})