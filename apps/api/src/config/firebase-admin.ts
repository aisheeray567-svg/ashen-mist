import * as admin from 'firebase-admin';

export const initializeFirebaseAdmin = () => {
    if (!admin.apps.length) {
        admin.initializeApp({
            credential: admin.credential.applicationDefault(),
            projectId: 'ashen-mist',
        });
    }
    return admin;
};
