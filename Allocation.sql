
use fp_DEMO;

select *, 
(
    SELECT sum(validate_units.teuSizeEquivalent)
    FROM Ftrans
    JOIN Ftrans_Ext ON Ftrans.rowid = Ftrans_Ext.rowid
    JOIN ShipmentLegs ONFtrans.rowid = ShipmentLegs.FtransRowid AND ShipmentLegs.BlLeg = 'Yes'
    JOIN Fmilestone ON Ftrans.rowid = Fmilestone.rec_num AND Fmilestone.source_file = 'Ftrans'
    JOIN Fcontainer ON Ftrans.rowid = Fcontainer.file_record AND Fcontainer.file = 'Ftrans'
    JOIN NON.validate_units ON Fcontainer.container_size = validate_units.unit_abbreviation
    
    WHERE Ftrans.last_completed_milestone < 98
    AND Ftrans.shipment_type = 'FCL'
    AND ShipmentLegs.FcarrierCarrierCode = Allocation.CarrierID
    AND (
        (Allocation.duration IS NULL AND (WEEK (Ftrans.etd) + 1) = Allocation.instanceNumber)
        OR (
            Allocation.duration > 0 AND (WEEK (Ftrans.etd) + 1) >= Allocation.instanceNumber
            AND ( WEEK (Ftrans.etd) + 1 ) <= Allocation.instanceNumber + Allocation.duration - 1
        )
    )
    AND YEAR (Ftrans.etd) = Allocation.startYear
    AND (Allocation.TradeLane = Ftrans_Ext.tradelane OR  Allocation.TradeLane IS NULL)
    AND Fmilestone.leg_number = ShipmentLegs.LegNumber
    AND Fmilestone.port_code = Allocation.originPort
    AND (
        ( Ftrans.issyrinx = 'Y' AND Fmilestone.name IN ('O.CY_DEP', 'CY_DEP'))
        OR (Ftrans.issyrinx != 'Y' AND ( Fmilestone.autorate_code = 'POL' OR  Fmilestone.autosched_code = 'POL' ))
    )

) bookedAmount
from Allocation



