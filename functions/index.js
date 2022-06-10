const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

console.log("beans");

const payload = {
    notification: {
      title: `You have a message from "me"`,
      body: "contentMessage",
      badge: '1',
      sound: 'default'
    }
  }
  // Let push to the target device
  admin
    .messaging()
    .sendToDevice("f0pGtlmaT_C6uqldsZb1aN:APA91bHjpAyUxLAMTLmp_wk9XoukrKXmkZvt2ZNX-Gdqx2O2RNa70E6VzVyOmgnjscTmRfo799kHM205hB_Ekizx9faQB04Ogw4quLuaYPUsiHMajT5fXoOFUTlwi2SQD3ZfCKfOwH1W", payload)
    .then(response => {
      console.log('Successfully sent message:', response)
    })
    .catch(error => {
      console.log('Error sending message:', error)
    })
})

//
//exports.sendNotification = functions.firestore
//  .document('messages/1/{groupId2}/{message}')
//  .onCreate((snap, context) => {
//    console.log('----------------start function--------------------')
//
//    const doc = snap.data()
//    console.log(doc)
//
//    const idFrom = doc.idFrom
//    const idTo = doc.idTo
//    const contentMessage = doc.content
//
//    // Get push token user to (receive)
//    admin
//      .firestore()
//      .collection('users')
//      .where('id', '==', idTo)
//      .get()
//      .then(querySnapshot => {
//        querySnapshot.forEach(userTo => {
//          console.log(`Found user to: ${userTo.data().nickname}`)
//          if (userTo.data().pushToken && userTo.data().chattingWith !== idFrom) {
//            // Get info user from (sent)
//            admin
//              .firestore()
//              .collection('users')
//              .where('id', '==', idFrom)
//              .get()
//              .then(querySnapshot2 => {
//                querySnapshot2.forEach(userFrom => {
//                  console.log(`Found user from: ${userFrom.data().nickname}`)
//                  const payload = {
//                    notification: {
//                      title: `You have a message from "${userFrom.data().nickname}"`,
//                      body: contentMessage,
//                      badge: '1',
//                      sound: 'default'
//                    }
//                  }
//                  // Let push to the target device
//                  admin
//                    .messaging()
//                    .sendToDevice(userTo.data().pushToken, payload)
//                    .then(response => {
//                      console.log('Successfully sent message:', response)
//                    })
//                    .catch(error => {
//                      console.log('Error sending message:', error)
//                    })
//                })
//              })
//          } else {
//            console.log('Can not find pushToken target user')
//          }
//        })
//      })
//    return null
//  })