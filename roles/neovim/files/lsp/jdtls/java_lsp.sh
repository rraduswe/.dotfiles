#!/bin/sh

JDT_LS_HOME="~/.config/nvim/lsp/jdtls"

JDT_LS_LAUNCHER=$(find $JDT_LS_HOME -name "org.eclipse.equinox.launcher_*.jar")
LOMBOK=$(find $JDT_LS_HOME -name "lombok.jar")

exec java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -noverify \
    -Xms1G \
    -Xmx2G \
    -javaagent:"$LOMBOK" \
    -Xbootclasspath/a:"$LOMBOK" \
    -jar "$JDT_LS_LAUNCHER" \
    -configuration "$JDT_LS_HOME/eclipse/config_mac" \
    -data "$1" \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED \
