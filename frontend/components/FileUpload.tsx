import { useState } from "react"

export default function FileUpload() {
  const [file, setFile] = useState<File | null>(null)
  const [msg, setMsg] = useState<string>("")

  const handleUpload = async () => {
    if (!file) return
    const formData = new FormData()
    formData.append("file", file)
    const res = await fetch("http://localhost:8000/upload", {
      method: "POST",
      body: formData,
      credentials: "include"
    })
    const data = await res.json()
    setMsg(`✅ ${data.message}, Transactions: ${data.count}`)
  }

  return (
    <div className="p-4">
      <input type="file" onChange={(e) => setFile(e.target.files?.[0] || null)} />
      <button onClick={handleUpload} className="bg-blue-500 text-white px-4 py-2 rounded ml-2">Upload</button>
      <p className="mt-2">{msg}</p>
    </div>
  )
}
