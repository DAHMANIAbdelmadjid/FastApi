To get a list of doctors from your API, you must send a GET request to the following path:

---

### ✅ **Request:**

**URL:**

```
GET /api/clinic/doctors
```

**Full URL (e.g., local server):**

```
http://localhost:5245/api/clinic/doctors
```

**Request Type:**
`GET`

**Headers (required):**

```http
Accept: application/json
Authorization: Bearer {token} ← If the API is protected with JWT
```

---

### 🧪 Example using `curl`:

```bash
curl -X GET "http://localhost:5245/api/clinic/doctors" ^
-H "Accept: application/json" ^
-H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

Or without a token if not required:

```bash
curl -X GET "http://localhost:5245/api/clinic/doctors" -H "Accept: application/json"
```

---

### 📌 Is there a filter?

The file doesn't show any filters (such as specialty or city) in `/api/clinic/doctors`, but they can be added later as Query Params like this:

```
/api/clinic/doctors?Specialization=1&City=Adrar
```