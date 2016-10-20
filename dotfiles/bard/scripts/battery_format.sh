case $status in
        Full)
                ICON=""
                ;;
        Charging)
                ICON=""
                ;;
        Discharging)
                ICON=""
                ;;
        *)
                ICON="??"
esac
echo "%{F$batcolor} $ICON $percentage%"
