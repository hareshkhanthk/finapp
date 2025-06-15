from fastapi import Depends, HTTPException, Header
import firebase_admin
from firebase_admin import auth as firebase_auth, credentials

cred = credentials.Certificate("firebase-admin-sdk.json")
firebase_admin.initialize_app(cred)

def get_current_user(authorization: str = Header(...)):
    try:
        token = authorization.split("Bearer ")[-1]
        decoded = firebase_auth.verify_id_token(token)
        return decoded
    except Exception:
        raise HTTPException(status_code=401, detail="Invalid Firebase token")
