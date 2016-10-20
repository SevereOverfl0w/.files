NETWORK=$network
COLOR=$connectcolor
if [ -z "$NETWORK" ]; then
        NETWORK="Disconnected"
        COLOR=$disconnectcolor
fi
echo "%{F$COLOR}  $NETWORK"
