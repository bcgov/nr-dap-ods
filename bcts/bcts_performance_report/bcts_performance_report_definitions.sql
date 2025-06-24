DROP TABLE IF EXISTS bcts_reporting.bcts_performance_report_definitions;

-- Create the table
CREATE TABLE bcts_reporting.bcts_performance_report_definitions (
    id SERIAL PRIMARY KEY,
    term TEXT,
    definition TEXT
);

-- Insert values
INSERT INTO bcts_reporting.bcts_performance_report_definitions (Term, Definition) VALUES
('Licence Issued Target', 'Cumulative target volume of timber sold in issued licences for the end of the current quarter, updated quarterly.'),
('Auctioned', 'New-to-market auctions. Includes issued licences, awarded licences that are not yet issued, and licences not awarded. Excludes reauctions. Licence Issued volume may exceed Auctioned volume when the first auction of a licence occurs in a previous fiscal.'),
('Currently in Market', 'Open to bidders on BC Bid at the end of the reporting period. Includes reauctions.'),
('Licence Issued', 'Volume of timber sold in issued licences. Issued licences may be first auctioned in a previous fiscal and not appear in this report’s Auctioned volume.'),
('Not Awarded', 'Volume of timber in auctioned licences that did not have a successful bidder. Includes reauctioned licences.'),
('Auctioned Target: Value Added', 'Cumulative target volume of timber volume auctioned, targeted at the value-added sector for the end of the current quarter, updated quarterly. Based on 20% of the Rationalized Apportionment of 6,467,328 m³, proportionate to quarterly target.'),
('Auctioned: Value Added', 'New-to-market Value Added auctions. Includes issued licences, awarded licences that are not yet issued, and licences not awarded. Excludes reauctions.'),
('Currently in Market: Value Added', 'Value Added volume open to bidders on BC Bid at the end of the reporting period. Includes reauctions.'),
('Licence Issued: Value Added', 'Volume of timber sold in Value Added issued licences. Issued licences may be first auctioned in a previous fiscal and not appear in this report’s Auctioned: Value Added volume.'),
('Not Awarded: Value Added', 'No successful bidder for licence advertised as Value Added; to be reauctioned.');
