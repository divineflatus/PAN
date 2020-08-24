delete from Drive
where DriveTitle in (select DriveTitle from NullDriveTotals where TotalFunded is Null);