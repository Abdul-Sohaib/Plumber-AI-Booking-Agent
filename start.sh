#!/bin/sh
set -e

# Paths
TEMPLATE="/usr/share/nginx/html/script.js.template"
OUT="/usr/share/nginx/html/script.js"

# Provide defaults if environment variables not set.
# You can override these by passing -e EMAILJS_USER_ID=... to docker run
: ${EMAILJS_USER_ID:="I1sz_o0pl5RWRr-jR"} 
: ${EMAILJS_SERVICE_ID:="service_g9e6nwv"}
: ${EMAILJS_TEMPLATE_ID:="template_wb8w9iq"}

# Export for envsubst
export EMAILJS_USER_ID
export EMAILJS_SERVICE_ID
export EMAILJS_TEMPLATE_ID

if [ -f "$TEMPLATE" ]; then
  echo "Generating script.js from template..."
  envsubst '__EMAILJS_USER_ID__ __EMAILJS_SERVICE_ID__ __EMAILJS_TEMPLATE_ID__' < "$TEMPLATE" > "$OUT"
else
  echo "script.js.template not found, skipping substitution."
fi

# Start nginx in foreground
exec nginx -g 'daemon off;'
