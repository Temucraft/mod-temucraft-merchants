-- mod-temucraft-merchants: player-facing texts. Translations go in module_string_locale (same module and id, plus the locale).
DELETE FROM `module_string` WHERE `module` = 'mod-temucraft-merchants';
INSERT INTO `module_string` (`module`, `id`, `string`) VALUES
('mod-temucraft-merchants', 1, '|cffff4c4cYour bags are full.|r'),
('mod-temucraft-merchants', 2, '|cffffcc00You pack {} x {} into the crate and seal it. A supply quartermaster will want it.|r'),
('mod-temucraft-merchants', 3, '|cffffcc00This crate wants {} x {}.|r');
