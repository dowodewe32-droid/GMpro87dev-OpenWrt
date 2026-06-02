// GMpro87devWRT - Luci UI Customizations
(function() {
  'use strict';

  // Wait for DOM to be ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initGMpro87dev);
  } else {
    initGMpro87dev();
  }

  function initGMpro87dev() {
    // Update page title
    document.title = document.title.replace(/LuCI|OpenWrt/g, 'GMpro87devWRT');

    // Custom logo in header
    var logo = document.querySelector('.brand .logo');
    if (logo) {
      // Let CSS handle the display
    }

    // Update footer
    var footerLinks = document.querySelectorAll('.footer a');
    footerLinks.forEach(function(link) {
      if (link.textContent.includes('OpenWrt') || link.textContent.includes('LuCI')) {
        link.textContent = 'GMpro87devWRT';
        link.href = 'https://github.com/dowodewe32-droid/GMpro87dev-OpenWrt';
      }
    });

    // Add version info
    var nodeInfo = document.querySelector('.node-info');
    if (nodeInfo) {
      var span = document.createElement('span');
      span.className = 'label label-danger';
      span.textContent = 'GMpro87devWRT';
      nodeInfo.parentNode.insertBefore(span, nodeInfo);
    }
  }
})();
