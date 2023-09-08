R=credentials
- vertical access control
  * unprotected admin
    - obscure /unpredictable admin URL -> parse JS for URLs
  * parameter-based access control
    - parameters used access admin URL -> add / update `admin=true` / `role=1`
  * broken access control from misconfigurations
   - 403 bypass using `X-Original-URL` / `X-Rewrite-URL`
   - 403 bypass using different method
- horizontal access control
  * user input to access objects directly (IDOR) -> modify input to obtain access
  * GUID-based parameters are not guessable -> explore the app for leaks
  * common ID structures
- multi-step access control vuln
  * app implements controls over some steps but ignores others -> skip validated steps
- referer-based access control
  * admin functs inspects the referer -> edit referer to match the desided URL
