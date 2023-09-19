const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

//http request method
exports.sendHttpPushNotification = functions.https.onRequest((req, res) => {
    const fcm = req.body.fcm; //get params like this
    console.log(fcm +"fcm");


    const payload = {
        token: req.body.fcm,
        notification: {
            title: 'cloud function demo',
            body: "message"
        },
        data: {
            body: "data msg",
        }
    };

    admin.messaging().send(payload).then((response) => {
        // Response is a message ID string.
        console.log('Successfully sent message:', response);
        return { success: true };
    }).catch((error) => {
        return { error: error.code };
    });



})