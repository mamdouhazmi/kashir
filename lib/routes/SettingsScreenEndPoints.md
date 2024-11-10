
## Tax Settings

- `GET /api/settings/tax` - Get tax configuration
- `PUT /api/settings/tax` - Update tax settings

```json
 Request Body: {Request Body}: {
  "commercialRegistration": "string",
  "taxNumber": "string",
  "taxRate": "number",
  "taxName": "string"
}

```




## Restaurant Settings

- `GET /api/settings/restaurant` - Get restaurant-specific settings
- `PUT /api/settings/restaurant` - Update restaurant settings

```json
 Request Body: {Request Body}: {
  "tableCount": "number",
  "serviceCharge": "number",
  "orderTypes": "array",
  "kitchenPrinters": "array"
}

```




## Password Management

- `GET /api/settings/security/roles` - Get user roles and permissions
- `PUT /api/settings/security/password` - Update user password

```json
 Request Body: {Request Body}: {
  "userId": "string",
  "currentPassword": "string",
  "newPassword": "string"
}

```


- `POST /api/settings/security/users` - Create new user
- `PUT /api/settings/security/users/{id}` - Update user permissions


## Custom Fields

- `GET /api/settings/custom-fields` - Get custom fields configuration
- `POST /api/settings/custom-fields` - Create new custom field

```json
 Request Body: {Request Body}: {
  "name": "string",
  "type": "string",
  "required": "boolean",
  "options": "array?",
  "defaultValue": "any"
}

```


- `PUT /api/settings/custom-fields/{id}` - Update custom field
- `DELETE /api/settings/custom-fields/{id}` - Delete custom field


## Other Settings

- `GET /api/settings/printer` - Get printer configurations
- `PUT /api/settings/printer` - Update printer settings
- `GET /api/settings/backup` - Get backup settings
- `POST /api/settings/backup` - Create system backup
- `GET /api/settings/language` - Get language preferences
- `PUT /api/settings/language` - Update language settings


## Response Format

All endpoints should return responses in the following format:

```json
 {
  "success": "boolean",
  "data": "object",
  "message": "string",
  "errors": "array?"
}

```

## Settings Object Structure

```json
 {
  "project": {
    "name": "string",
    "contactInfo": {
      "address": "string",
      "phone": "string",
      "additionalInfo": "string[]"
    }
  },
  "tax": {
    "commercialRegistration": "string",
    "taxNumber": "string",
    "taxRate": "number",
    "taxName": "string"
  },
  "restaurant": {
    "enabled": "boolean",
    "settings": "object"
  },
  "security": {
    "passwordPolicy": "object",
    "userRoles": "array"
  },
  "customFields": "array",
  "other": {
    "printerConfig": "object",
    "backupSettings": "object",
    "language": "string"
  }
}

```

## Authentication

All endpoints require a valid JWT token in the Authorization header:
`Authorization: Bearer {token}`

## Error Codes

- `400` - Bad Request (Invalid input)
- `401` - Unauthorized
- `403` - Forbidden (Insufficient permissions)
- `404` - Setting not found
- `500` - Internal Server Error


```plaintext

```