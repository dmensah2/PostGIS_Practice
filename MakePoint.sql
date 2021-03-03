UPDATE region_licenses_all_20200828

SET geom = ST_SetSRID(ST_MakePoint(lon, lat),4326)