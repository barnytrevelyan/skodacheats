# Latest Updates to UberCheats

## What's New

### 1. **Visual Enhancements**
- Hero header with Unsplash background image
- Better visual hierarchy and branding
- Improved layout and spacing

### 2. **File Upload Support**
- Users can now upload evidence (screenshots, receipts, etc.)
- Supported formats: JPG, PNG, PDF
- Maximum 5MB per file
- Multiple files supported per complaint
- Files stored in Supabase Storage (public & accessible)
- Uploaded files displayed on complaint view pages

### 3. **Uber Order Number Field**
- New optional field for Uber order numbers
- Helps identify and trace specific orders
- Display on complaint cards for easy reference
- Encourages users to provide order references

### 4. **Database Enhancements**
- Added `uber_order_number` column
- Added `file_urls` array column for file storage
- Migration script provided: `supabase-migration.sql`

### 5. **Updated Components**
- **ComplaintForm.js**: Now supports file uploads and order number input
- **ComplaintList.js**: Displays evidence files and order numbers
- **pages/index.js**: Added hero image and better styling
- **pages/api/complaints.js**: Handles multipart form data and file uploads

### 6. **New Files**
- `supabase-migration.sql` - Migration to add new columns
- `STORAGE_SETUP.md` - Instructions for setting up Supabase Storage bucket

## Installation & Deployment

### Before Deploying:

1. **Run the migration SQL** in Supabase:
   - Go to SQL Editor
   - Run `supabase-migration.sql`

2. **Create Storage Bucket** in Supabase:
   - Go to Storage → Create new bucket
   - Name: `complaints`
   - Toggle: Public bucket ON

3. **Install new dependencies locally:**
   ```bash
   npm install
   ```

### Deploy:

```bash
git add .
git commit -m "Add file uploads, Uber order numbers, and hero images"
git push
```

Vercel will auto-deploy. No new environment variables needed.

## Files Changed/Added

### Modified Files:
- `pages/index.js` - Hero header with image
- `pages/api/complaints.js` - File upload handler
- `components/ComplaintForm.js` - File input & order number field
- `components/ComplaintList.js` - Display files & order numbers
- `package.json` - Added formidable dependency

### New Files:
- `supabase-migration.sql` - Database migration
- `STORAGE_SETUP.md` - Setup instructions
- `UPDATES.md` - This file

## User Experience

### When Submitting a Complaint:
1. Fill form as before
2. (NEW) Enter Uber order number (optional)
3. (NEW) Upload evidence files (JPG, PNG, PDF)
4. Submit

### When Viewing Complaints:
1. See regular complaint details
2. (NEW) See Uber order number if provided
3. (NEW) See clickable evidence file links
4. Click to view/download uploaded evidence

## Technical Details

- Uses **formidable** library to parse multipart form data
- Files uploaded to **Supabase Storage** bucket
- Public file URLs returned and stored in database
- File validation: type, size limits
- Error handling for upload failures (non-blocking)

## Security & Privacy

- Supabase RLS still protects database operations
- Public bucket allows anyone to view evidence (intentional for transparency)
- File names timestamped to prevent collisions
- No file size limits enforced at API (handled by frontend)

## Testing Locally

```bash
npm install
npm run dev
```

1. Visit http://localhost:3000
2. Go to "Report an Issue"
3. Fill form including new fields
4. Upload a test image (JPG)
5. Submit
6. Go to "View Cases" to see the complaint with file links
7. Click evidence link to verify file upload

## Known Limitations

- Files stored publicly (by design for transparency)
- No file size limit on backend (enforce with frontend validation)
- No virus scanning (consider adding in future)
- No file deletion (immutable like complaints)

## Next Steps (Future Enhancements)

- Add virus scanning to uploaded files
- Compress images before storage
- Add file preview in UI
- Add file count/size display
- Email notifications when complaint receives files
