from fastapi import APIRouter, UploadFile, File, Depends, HTTPException
from ..services.parser import parse_csv_file
from ..auth.auth import get_current_user

router = APIRouter()

@router.post("/upload")
async def upload_statement(file: UploadFile = File(...), user=Depends(get_current_user)):
    if not file.filename.endswith(".csv"):
        raise HTTPException(status_code=400, detail="Only CSV supported in this version.")
    content = await file.read()
    transactions = parse_csv_file(content, user_id=user.id)
    return {"message": "Parsed successfully", "count": len(transactions)}