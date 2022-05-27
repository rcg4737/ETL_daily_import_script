USE [Database Goes Here]
GO



-------------------------------------   TESTING	  --------------------------------------------
/****** Object:  Table [dbo].[TestAceAudits]    Script Date: 2/10/2022 10:30:50 AM ******/
--Drop TABLE [dbo].[TestAceAudits]

--CREATE TABLE [dbo].[TestAceAudits](
--	[LoanNumber] [varchar](500) NULL,
--	[Manager Final Review Complete Date] [datetime] NULL,
--	[Category] [varchar](11) NOT NULL,
--	[AuditName] [varchar](max) NULL
--) 
--GO

--insert into [dbo].[TestAceAudits]
--select loannumber, [Manager Final Review Complete Date], Category, AuditName
--from [zReporting_RiskAnalytics].[dbo].[AcesAudits]

select * from [dbo].[TestAceAudits] order by [Manager Final Review Complete Date] desc



--IF EXISTS (SELECT 1 FROM information_schema.tables where table_name like 'Staging_AceAudits')
--    DROP TABLE Staging_AceAudits;

--CREATE TABLE [zReporting_RiskAnalytics].[dbo].[Staging_AceAudits](
-- [LoanNumber] [varchar](500) NULL,
-- [Manager Final Review Complete Date] [datetime] NULL,
-- [Category] [varchar](11) NOT NULL,
-- [AuditName] [varchar](max) NULL);




--BEGIN TRANSACTION [Tran1]

--	BEGIN TRY
--		--Updates AuditNmae in AceAudit table that are NULL
--		UPDATE [Reporting_RiskAnalytics].[dbo].[AcesAudits] 
--		SET [AcesAudits].[AuditName] = S.[AuditName]
--		FROM [Reporting_RiskAnalytics].[dbo].[AcesAudits] A
--		INNER JOIN [Reporting_RiskAnalytics].[dbo].[Staging_AceAudits] S ON S.LoanNumber = A.LoanNumber
--		WHERE A.[AuditName] IS NULL


--		--Insert row from staging table that are not in AcesAudit Table
--		INSERT INTO [Reporting_RiskAnalytics].[dbo].[AcesAudits]
--		SELECT A.LoanNumber, A.[Manager Final Review Complete Date], A.Category, A.AuditName
--		FROM  [Reporting_RiskAnalytics].[dbo].[Staging_AceAudits] A
--		WHERE A.LoanNumber  not in (select LoanNumber from [zReporting_RiskAnalytics].[dbo].[AcesAudits] )

--		-- Insert row into AceAudit with similar loan number but different audit name
--		INSERT INTO [Reporting_RiskAnalytics].[dbo].[AcesAudits]
--		SELECT S.LoanNumber, S.[Manager Final Review Complete Date], S.Category, S.AuditName
--		FROM  [Reporting_RiskAnalytics].[dbo].[Staging_AceAudits] S
--		INNER JOIN [Reporting_RiskAnalytics].[dbo].[AcesAudits] A ON S.LoanNumber = A.LoanNumber
--		WHERE S.LoanNumber in (select loannumber from [Reporting_RiskAnalytics].[dbo].[AcesAudits]) 
--		and S.AuditName != A.AuditName

--		COMMIT TRANSACTION [Tran1]

--	END TRY

--	BEGIN CATCH

--		ROLLBACK TRANSACTION [Tran1]

--	END CATCH