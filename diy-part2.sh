#!/bin/bash
# GMpro87devWRT - Part 2: Configuration and theme customization

# ============================================================
# System Configuration
# ============================================================

# Set default LAN IP
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# Enable IRQ balance for MT7621 (better performance)
sed -i 's/disabled=1/disabled=0/g' package/kernel/irq-cpu-hotplug/src/irq-cpu-hotplug.c 2>/dev/null || true

# ============================================================
# Package Optimization
# ============================================================

# Remove unnecessary packages from default install
sed -i 's/ \,kmod-ipt-offload//g' target/linux/ramips/image/mt7621.mk 2>/dev/null || true

# ============================================================
# GMpro87devWRT Luci Theme Customization
# ============================================================

# Header customization
HEADER_FILE="feeds/luci/themes/luci-theme-bootstrap/luasrc/view/themes/bootstrap/header.htm"
if [ -f "$HEADER_FILE" ]; then
  FIND='<link rel="stylesheet" href="<%=media%>/css/cascade.css" />'
  REPLACE='<link rel="stylesheet" href="<%=media%>/css/cascade.css" />\n\t<link rel="stylesheet" href="<%=media%>/css/gmpro87dev.css" />\n\t<script src="<%=resource%>/gmpro87dev.js"><\/script>'
  sed -i "s|$FIND|$REPLACE|g" "$HEADER_FILE"
fi

# Footer customization
FOOTER_FILE="feeds/luci/themes/luci-theme-bootstrap/luasrc/view/themes/bootstrap/footer.htm"
if [ -f "$FOOTER_FILE" ]; then
  FIND='Powered by <a href="https://openwrt.org">OpenWrt</a>'
  REPLACE='Powered by <a href="https://github.com/dowodewe32-droid/GMpro87dev-OpenWrt">GMpro87devWRT</a>'
  sed -i "s|$FIND|$REPLACE|g" "$FOOTER_FILE"
fi

# Login page customization
SYSauth_FILE="feeds/luci/themes/luci-theme-bootstrap/luasrc/view/themes/bootstrap/sysauth.htm"
if [ -f "$SYSauth_FILE" ]; then
  sed -i 's|LuCI - Lua Configuration Interface|GMpro87devWRT - Custom Firmware|g' "$SYSauth_FILE"
fi

# Status page - modify hostname display
STATUS_FILE="feeds/luci/modules/luci-mod-status/luasrc/view/admin_status/index.htm"
if [ -f "$STATUS_FILE" ]; then
  # Change LuCI version label to show custom firmware name
  sed -i 's|<%=luci.version%>|<%=luci.version%> \/ GMpro87devWRT|g' "$STATUS_FILE"
fi

echo "GMpro87devWRT customization applied!"
