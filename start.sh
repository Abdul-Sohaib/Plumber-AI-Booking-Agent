#!/bin/sh
set -e

# Template paths
TEMPLATE="/usr/share/nginx/html/script.js.template"
OUT="/usr/share/nginx/html/script.js"

# Default EmailJS values (you can override in docker run)
: ${EMAILJS_USER_ID:="I1sz_o0pl5RWRr-jR"}
: ${EMAILJS_SERVICE_ID:="service_g9e6nwv"}
: ${EMAILJS_TEMPLATE_ID:="template_wb8w9iq"}

# Default VAPI values (must override with real values from your dashboard)
: ${VAPI_ASSISTANT_ID:="77904230-4206-40ff-add4-4cdb9f45fb2a"}
: ${VAPI_PUBLIC_KEY:="672b4136-dc12-4f49-a864-1705b79933d9"}

# Export variables for envsubst
export EMAILJS_USER_ID EMAILJS_SERVICE_ID EMAILJS_TEMPLATE_ID
export VAPI_ASSISTANT_ID VAPI_PUBLIC_KEY

# Generate final script.js
if [ -f "$TEMPLATE" ]; then
  echo "Generating script.js from template with VAPI + EmailJS variables..."
  envsubst '
    __EMAILJS_USER_ID__
    __EMAILJS_SERVICE_ID__
    __EMAILJS_TEMPLATE_ID__
    __VAPI_ASSISTANT_ID__
    __VAPI_PUBLIC_KEY__
  ' < "$TEMPLATE" > "$OUT"
else
  echo "script.js.template not found — skipping substitution."
fi

# Start nginx
exec nginx -g 'daemon off;'
