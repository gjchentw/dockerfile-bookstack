# gjchen/bookstack@Dockerhub
** A PHP environment for hosting BookStack **

Usage:
* -e ENV=VALUE to override .env BookStack: https://www.bookstackapp.com/docs/admin/
* -v fontfile:DejaVuSans to change font for DOMPDF due to BookStack use DejaVuSans to export PDF
* -v any persistant data or shared files

```
docker run --name bookstack -d --restart unless-stopped -p 80:80 \
	-e "ALL VARS in .env you need" \
        -v normal.ttf:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans.ttf \
        -v normal.ufm:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans.ufm \
        -v bold.ttf:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ttf \
        -v bold.ufm:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Bold.ufm \
        -v bold_italic.ttf:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans-BoldOblique.ttf \
        -v bold_italic.ufm:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans-BoldOblique.ufm \
        -v italic.ttf:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Oblique.ttf \
        -v italic.ufm:/bookstack/vendor/dompdf/dompdf/lib/fonts/DejaVuSans-Oblique.ufm \
        -v storage/fonts:/bookstack/storage/fonts \
	-v bootstrap/cache:/bookstack/cache \
        -v bootstrap/public/uploads:/bookstack/bootstrap/public/uploads \
        gjchen/bookstack
	
```
