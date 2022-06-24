
SELECT * FROM [TrackTailApp].[AspNetUsers] where Email = 'lcabral@tailbase.com';
SELECT * FROM [TrackTailApp].[AspNetUsers] where Email like '%franco%';

SELECT * FROM  [datatail20130410].[TrackTailDb].[Websites] order by id


sELECT coalesce(max(r.AdminLevel),0) adminlevel FROM TrackTailApp.AspNetUserRoles ur
                    left join TrackTailApp.AspNetRoles r on r.id=ur.RoleId
                    where ur.UserId='b1ec3b6a-2c45-4cb6-a708-5688e56621a9'

SELECT TOP (100) [LogID]
      ,[Project]
      ,[Category]
      ,[Text]
      ,[Time]
      ,[Severity]
      ,[Module]
      ,[Location]
  FROM [EventReactor].[dbo].[Logs]
  where category = 'tracktail'
  order by [time] desc