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
('Licence Issued Target: Value Added (VA)', 'Cumulative target volume of timber sold in Value Added issued licences for the end of the current quarter, updated quarterly. Based on 10% of Rationalized Apportionment, proportionate to quarterly sales target.'),
('Auctioned: Value Added (VA)', 'New-to-market Value Added auctions. Includes issued licences, awarded licences that are not yet issued, and licences not awarded. Excludes reauctions.'),
('Currently in Market: Value Added (VA)', 'Value Added volume open to bidders on BC Bid at the end of the reporting period. Includes reauctions.'),
('Licence Issued: Value Added (VA)', 'Volume of timber sold in Value Added issued licences. Issued licences may be first auctioned in a previous fiscal and not appear in this report’s Auctioned: Value Added volume.'),
('Not Awarded: Value Added (VA)', 'No successful bidder for licence advertised as Value Added; to be reauctioned.');
