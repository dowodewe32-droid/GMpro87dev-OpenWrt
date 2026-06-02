#!/bin/bash
# GMpro87devWRT - Part 2: Post-configuration patches

# Set default LAN IP (leave as 192.168.1.1)
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# ============================================================
# GMpro87devWRT Luci Branding
# ============================================================

# Patch footer (works on both LuCI Lua and JS)
find feeds/luci -name "footer.htm" -path "*/bootstrap/*" 2>/dev/null | while read f; do
  sed -i 's|Powered by <a href="https://openwrt.org">OpenWrt</a>|Powered by <a href="https://github.com/dowodewe32-droid/GMpro87dev-OpenWrt">GMpro87devWRT</a>|g' "$f"
  echo "Patched footer: $f"
done

# Patch sysauth (login page)
find feeds/luci -name "sysauth.htm" -path "*/bootstrap/*" 2>/dev/null | while read f; do
  sed -i 's|LuCI - Lua Configuration Interface|GMpro87devWRT - Custom Firmware|g' "$f"
  echo "Patched login: $f"
done

# Patch header to inject custom CSS
find feeds/luci -name "header.htm" -path "*/bootstrap/*" 2>/dev/null | while read f; do
  FIND='<link rel="stylesheet" href="<%=media%>/css/cascade.css" />'
  REPLACE='<link rel="stylesheet" href="<%=media%>/css/cascade.css" />\n\t<link rel="stylesheet" href="<%=media%>/css/gmpro87dev.css" />\n\t<script src="<%=resource%>/gmpro87dev.js"><\/script>'
  sed -i "s|$FIND|$REPLACE|g" "$f"
  echo "Patched header: $f"
done

echo "GMpro87devWRT branding applied!"
