pkg load image; % Charger le package d'image

% Créer la figure de l'interface utilisateur
hFig = figure('Name', 'Traitement d''image MIA', 'NumberTitle', 'off');

% Créer le panneau pour les boutons de traitement
hButtonPanel = uipanel('Parent', hFig, 'Units', 'normalized', 'Position', [0.05, 0.05, 0.2, 0.9], ...
                       'Title', 'Boutons de traitement', 'BorderType', 'etchedin');

% Ajouter les boutons de traitement dans le panneau
uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Charger l''image', ...
          'Units', 'normalized', 'Position', [0.1, 0.91, 0.8, 0.07], 'Callback', @charger_image, ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12); % Taille de police 14px

% Bouton pour changer l'image en noir et blanc
uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Conversion en niveau de gris', ...
          'Units', 'normalized', 'Position', [0.1, 0.82, 0.8, 0.07], 'Callback', @convertir_niveau_gris, ...
          'BackgroundColor', [0.53, 0.81, 0.98], ...
          'FontName', 'Berlin Sans FB', ...
          'FontSize', 12);

uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Conversion binaire', ...
          'Units', 'normalized', 'Position', [0.1, 0.73, 0.8, 0.07], 'Callback', @convertir_binaire,
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12); % Taille de police 14px


uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Redimenssion', ...
          'Units', 'normalized', 'Position', [0.1, 0.64, 0.8, 0.07], 'Callback', @redimensionner_image, ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12); % Taille de police 14px


uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Rotation', ...
          'Units', 'normalized', 'Position', [0.1, 0.55, 0.8, 0.07], 'Callback', @exporter_image,
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12, ...  % Taille de police 14px
          'Callback', @rotation_image);

uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Réflexion', ...
          'Units', 'normalized', 'Position', [0.1, 0.46, 0.8, 0.07], ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12, ... % Taille de police
          'Callback', @reflexion_image); % Associer la fonction de réflexion


uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Affichage d'' histogramme', ...
          'Units', 'normalized', 'Position', [0.1, 0.37, 0.8, 0.07],
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12, ...   % Taille de police 14px
          'Callback', @afficher_histogramme);

uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Découpage', ...
          'Units', 'normalized', 'Position', [0.1, 0.28, 0.8, 0.07], ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12, ... % Taille de police
          'Callback', @decouper_image); % Associer la fonction de découpage


uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Afficher les contours', ...
          'Units', 'normalized', 'Position', [0.1, 0.19, 0.8, 0.07], ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12, ... % Taille de police
          'Callback', @afficher_contours); % Associer la fonction de détection de contours


uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Exporter', ...
          'Units', 'normalized', 'Position', [0.1, 0.1, 0.8, 0.07], ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12, ... % Taille de police
          'Callback', @exporter_image); % Associer la fonction d'exportation


uicontrol('Parent', hButtonPanel, 'Style', 'pushbutton', 'String', 'Rétablir par défaut', ...
          'Units', 'normalized', 'Position', [0.1, 0.01, 0.8, 0.07], ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12, ... % Taille de police
          'Callback', @reinitialiser_image); % Associer la fonction de réinitialisation


% Ajouter un axe avec un Tag unique
hAxes = axes('Parent', hFig, 'Units', 'normalized', 'Position', [0.28, 0.25, 0.3, 0.7], 'Tag', 'ImageDisplayAxes', ...
              'Box', 'on', 'XColor', 'k', 'YColor', 'k');

% Ajouter un axe avec un Tag unique pour histogramme
hAxesHistogramme = axes('Parent', hFig, 'Units', 'normalized', 'Position', [0.64, 0.25, 0.3, 0.7], ...
                        'Box', 'on', 'XColor', 'k', 'YColor', 'k', 'Tag', 'ImageHistogramAxes');


global img img_original img_modifiee; % Ajouter img_original

function charger_image(~, ~)
    global img img_original img_modifiee;

    % Retrouver l'axe avec le Tag unique
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Ouvrir un sélecteur de fichier pour choisir l'image
    [file, path] = uigetfile({'*.jpg;*.png;*.bmp', 'Fichiers Image (*.jpg, *.png, *.bmp)'}, 'Sélectionnez une image');
    if isequal(file, 0)
        return; % Annulation par l'utilisateur
    end

    try
        img = imread(fullfile(path, file));
        img_original = img; % Stocker une copie de l'image originale
        img_modifiee = img; % Stocker l'image comme image modifiée initiale
    catch
        errordlg('Erreur lors du chargement de l''image. Format non supporté ou fichier corrompu.', 'Erreur de chargement');
        return;
    end

    % Afficher l'image sur l'axe
    axes(hAxes);
    imshow(img, []);
    title(hAxes, 'Image chargée', 'FontSize', 10, 'FontWeight', 'bold');
end



% Fonction pour convertir l'image en niveau de gris
function convertir_niveau_gris(~, ~)
    global img img_modifiee;

    % Retrouver l'axe avec le Tag unique
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Vérifier si une image est affichée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    % Convertir en image binaire
    img_modifiee = rgb2gray(img); % Convertir en niveaux de gris


    % Afficher l'image en noir et blanc
    axes(hAxes);
    imshow(img_modifiee);
    title(hAxes, 'Image en niveau de gris', 'FontSize', 10, 'FontWeight', 'bold');
end


% Fonction pour convertir l'image en binaire
function convertir_binaire(~, ~)
    global img img_modifiee;

    % Retrouver l'axe avec le Tag unique
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Vérifier si une image est affichée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

     % Convertir en niveaux de gris si nécessaire
    if size(img, 3) == 3
        img_gray = rgb2gray(img); % Convertir en niveaux de gris
    else
        img_gray = img; % Déjà en niveaux de gris
    end

    % Calculer le seuil global avec la méthode d'Otsu
    seuil = graythresh(img_gray); % Renvoie un seuil entre 0 et 1

    % Convertir en binaire
    img_modifiee = im2bw(img_gray, seuil); % Appliquer le seuil pour obtenir une image binaire

    % Afficher l'image en noir et blanc
    axes(hAxes);
    imshow(img_modifiee);
    title(hAxes, 'Image binaire', 'FontSize', 10, 'FontWeight', 'bold');
end


% Fonction pour afficher l'histogramme de l'image
function afficher_histogramme(~, ~)
    global img;

    % Vérifier si une image est chargée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    % Retrouver l'axe pour l'histogramme avec le Tag unique
    hAxesHistogramme = findobj('Tag', 'ImageHistogramAxes');
    if isempty(hAxesHistogramme) || ~ishandle(hAxesHistogramme)
        errordlg('Aucun axe valide trouvé pour afficher l''histogramme.', 'Erreur d''affichage');
        return;
    end

    % Activer l'axe de l'histogramme et le nettoyer avant de dessiner
    axes(hAxesHistogramme);
    cla(hAxesHistogramme);

    % Affichage de l'histogramme selon le type d'image
    if size(img, 3) == 3
        % Image couleur : afficher les histogrammes des trois canaux
        img_red = img(:, :, 1);
        img_green = img(:, :, 2);
        img_blue = img(:, :, 3);

        hold on; % Permet de superposer les histogrammes des trois canaux
        red_hist = imhist(img_red);
        green_hist = imhist(img_green);
        blue_hist = imhist(img_blue);

        bar(0:255, red_hist, 'r', 'EdgeColor', 'none', 'FaceAlpha', 0.5); % Rouge
        bar(0:255, green_hist, 'g', 'EdgeColor', 'none', 'FaceAlpha', 0.5); % Vert
        bar(0:255, blue_hist, 'b', 'EdgeColor', 'none', 'FaceAlpha', 0.5); % Bleu
        hold off;

        title(hAxesHistogramme, 'Histogramme des canaux RGB', 'FontSize', 10, 'FontWeight', 'bold');
    else
        % Image en niveaux de gris
        gray_hist = imhist(img);
        bar(0:255, gray_hist, 'FaceColor', [0.5, 0.5, 0.5], 'EdgeColor', 'none');

        title(hAxesHistogramme, 'Histogramme en niveaux de gris', 'FontSize', 10, 'FontWeight', 'bold');
    end

    % Configurer l'axe pour une meilleure lisibilité
    xlim([0, 255]);
    xlabel('Intensité des pixels', 'FontSize', 10);
    ylabel('Nombre de pixels', 'FontSize', 10);
    grid on; % Ajouter une grille pour une meilleure visualisation
end



% Fonction pour effectuer une rotation de l'image
function rotation_image(~, ~)
    global img img_modifiee;

    % Vérifier si une image est chargée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    % Retrouver l'axe pour l'affichage de l'image
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Demander à l'utilisateur l'angle de rotation
    prompt = {'Entrez l''angle de rotation (degrés) :'};
    dlgtitle = 'Rotation de l''image';
    answer = inputdlg(prompt, dlgtitle, [1 35], {'90'});

    if isempty(answer)
        return; % L'utilisateur a annulé
    end

    angle = str2double(answer{1});

    if isnan(angle)
        errordlg('Veuillez entrer un angle valide.', 'Erreur de rotation');
        return;
    end

    % Effectuer la rotation
    try
        img_modifiee = imrotate(img, angle, 'bilinear', 'crop'); % Rotation sans modifier les dimensions
        img = img_modifiee;

        % Afficher l'image tournée
        axes(hAxes);
        imshow(img, []);
        title(hAxes, ['Image tournée de ', num2str(angle), '°'], 'FontSize', 10, 'FontWeight', 'bold');
    catch
        errordlg('Erreur lors de la rotation de l''image.', 'Erreur');
    end
end


function reinitialiser_image(~, ~)
    global img img_original;

    % Vérifier si une image originale est chargée
    if isempty(img_original)
        errordlg('Aucune image originale à rétablir.', 'Erreur de réinitialisation');
        return;
    end

    % Retrouver l'axe pour l'affichage de l'image
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Rétablir l'image à l'état original
    img = img_original;

    % Afficher l'image originale sur l'axe
    axes(hAxes);
    imshow(img, []);
    title(hAxes, 'Image rétablie par défaut', 'FontSize', 10, 'FontWeight', 'bold');
end



% Fonction pour la réflexion de l'image
function reflexion_image(~, ~)
    global img img_modifiee;

    % Vérifier si une image est chargée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    % Retrouver l'axe pour l'affichage de l'image
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Première question : Choix entre réflexion horizontale ou verticale
    choixType = questdlg('Choisissez le type de réflexion :', ...
                         'Type de réflexion', ...
                         'Horizontale', 'Verticale', 'Annuler', 'Horizontale');

    if isempty(choixType) || strcmp(choixType, 'Annuler')
        return; % L'utilisateur a annulé ou fermé la boîte de dialogue
    end

    % Deuxième question : Sens spécifique
    if strcmp(choixType, 'Horizontale')
        choixSens = questdlg('Choisissez le sens de la réflexion horizontale :', ...
                             'Sens de réflexion', ...
                             'Gauche', 'Droite', 'Annuler', 'Gauche');
    else
        choixSens = questdlg('Choisissez le sens de la réflexion verticale :', ...
                             'Sens de réflexion', ...
                             'Haut', 'Bas', 'Annuler', 'Haut');
    end

    if isempty(choixSens) || strcmp(choixSens, 'Annuler')
        return; % L'utilisateur a annulé ou fermé la boîte de dialogue
    end

    % Appliquer la réflexion selon le type et le sens choisis
    try
        switch choixType
            case 'Horizontale'
                if strcmp(choixSens, 'Gauche')
                    img_modifiee = flip(img(:, 1:floor(end/2), :), 2); % Gauche
                    img(:, 1:floor(end/2), :) = img_modifiee;
                else
                    img_modifiee = flip(img(:, floor(end/2):end, :), 2); % Droite
                    img(:, floor(end/2):end, :) = img_modifiee;
                end
            case 'Verticale'
                if strcmp(choixSens, 'Haut')
                    img_modifiee = flip(img(1:floor(end/2), :, :), 1); % Haut
                    img(1:floor(end/2), :, :) = img_modifiee;
                else
                    img_modifiee = flip(img(floor(end/2):end, :, :), 1); % Bas
                    img(floor(end/2):end, :, :) = img_modifiee;
                end
        end

        % Mettre à jour l'image et l'afficher
        axes(hAxes);
        imshow(img, []);
        title(hAxes, ['Image réfléchie (', choixType, ' - ', choixSens, ')'], 'FontSize', 10, 'FontWeight', 'bold');
    catch ME
        errordlg(['Erreur lors de la réflexion : ', ME.message], 'Erreur');
    end
end



%Fonction de détection de contour
function afficher_contours(~, ~)
    global img img_modifiee;

    % Vérifier si une image est chargée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    % Retrouver l'axe pour l'affichage de l'image
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Convertir en niveaux de gris si l'image est en couleur
    if size(img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end

    % Appliquer la détection des contours avec l'algorithme de Canny
    img_modifiee = edge(img_gray, 'Canny');

    % Afficher les contours sur l'axe
    axes(hAxes);
    imshow(img_modifiee);
    title(hAxes, 'Contours de l''image', 'FontSize', 10, 'FontWeight', 'bold');
end


% Fonction pour découper l'image
function decouper_image(~, ~)
    global img img_modifiee;

    % Vérifier si une image est chargée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    % Retrouver l'axe pour l'affichage de l'image
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    % Demander à l'utilisateur le nombre de découpages
    prompt = {'Entrez le nombre de découpages horizontaux :', ...
              'Entrez le nombre de découpages verticaux :'};
    dlgtitle = 'Paramètres de découpage';
    dims = inputdlg(prompt, dlgtitle, [1 1], {'1', '1'});

    if isempty(dims)
        return; % L'utilisateur a annulé
    end

    try
        nRows = str2double(dims{1});
        nCols = str2double(dims{2});

        if isnan(nRows) || isnan(nCols) || nRows <= 0 || nCols <= 0
            errordlg('Veuillez entrer des valeurs valides pour le découpage.', 'Erreur de saisie');
            return;
        end

        % Calculer la taille de chaque découpage
        [height, width, ~] = size(img);
        rowHeight = floor(height / nRows);
        colWidth = floor(width / nCols);

        % Permettre à l'utilisateur de sélectionner une région spécifique
        msgbox('Cliquez sur une région pour découper.', 'Instruction', 'help');

        % Activer la sélection de régions
        axes(hAxes);
        imshow(img);
        for i = 1:nRows
            for j = 1:nCols
                x1 = (j - 1) * colWidth + 1;
                y1 = (i - 1) * rowHeight + 1;
                rectangle('Position', [x1, y1, colWidth, rowHeight], 'EdgeColor', 'r');
            end
        end

        % Attendre que l'utilisateur sélectionne une région
        [x, y] = ginput(1);

        % Trouver la région sélectionnée
        selectedCol = min(floor(x / colWidth) + 1, nCols);
        selectedRow = min(floor(y / rowHeight) + 1, nRows);

        % Découper l'image
        x1 = (selectedCol - 1) * colWidth + 1;
        y1 = (selectedRow - 1) * rowHeight + 1;
        img_cropped = imcrop(img, [x1, y1, colWidth - 1, rowHeight - 1]);

        % Mettre à jour l'image affichée
        img = img_cropped;
        img_modifiee = img;

        imshow(img_modifiee, []);
        title(hAxes, 'Image découpée', 'FontSize', 10, 'FontWeight', 'bold');

    catch
        errordlg('Erreur lors de la sélection de la région ou du découpage.', 'Erreur');
    end
end



% Fonction pour exporter l'image
function exporter_image(~, ~)
    global img_modifiee;
    if isempty(img_modifiee)
        errordlg('Aucune image n''a été chargée ou modifiée.', 'Erreur d''exportation');
        return;
    end

    [file, path, filterindex] = uiputfile({'*.jpg', 'Fichier JPEG (*.jpg)'; ...
                                           '*.png', 'Fichier PNG (*.png)'; ...
                                           '*.bmp', 'Fichier BMP (*.bmp)'}, ...
                                           'Exporter l''image sous...');

    if isequal(file, 0) || isequal(path, 0)
        return;
    end

    fullFileName = fullfile(path, file);

    try
        switch filterindex
            case 1
                imwrite(img_modifiee, fullFileName, 'jpg');
            case 2
                imwrite(img_modifiee, fullFileName, 'png');
            case 3
                imwrite(img_modifiee, fullFileName, 'bmp');
            otherwise
                errordlg('Format non pris en charge.', 'Erreur');
                return;
        end
        msgbox(['Image exportée avec succès sous ', fullFileName], 'Succès');
    catch ME
        errordlg(['Erreur lors de l''exportation de l''image : ', ME.message], 'Erreur');
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Fonction pour redimensionner l'image
function redimensionner_image(~, ~)
    global img img_modifiee;

    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    hAxes = findobj('Tag', 'ImageDisplayAxes');
    if isempty(hAxes) || ~ishandle(hAxes)
        errordlg('Aucun axe valide trouvé pour afficher l''image.', 'Erreur d''affichage');
        return;
    end

    try
        prompt = {'Largeur (pixels) :', 'Hauteur (pixels) :'};
        dlgtitle = 'Dimensions de redimensionnement';
        dims = inputdlg(prompt, dlgtitle, [1 1], {'300', '300'});

        if isempty(dims)
            return;
        end

        largeur = round(str2double(dims{1}));
        hauteur = round(str2double(dims{2}));

        if isnan(largeur) || isnan(hauteur) || largeur <= 0 || hauteur <= 0
            errordlg('Entrez des dimensions valides.', 'Erreur de redimensionnement');
            return;
        end

        img_resized = imresize(img, [hauteur, largeur]);
        if isempty(img_resized)
            errordlg('Erreur lors du redimensionnement.', 'Erreur');
            return;
        end
        img = img_resized;
        img_modifiee = img; % Mettre à jour l'image modifiée
    catch
        errordlg('Erreur lors du redimensionnement.', 'Erreur');
        return;
    end

    axes(hAxes);
    imshow(img_modifiee, []);
    title(hAxes, 'Image redimensionnée', 'FontSize', 10, 'FontWeight', 'bold');
end


% Créer le panneau pour les boutons supplémentaires
hExtraPanel = uipanel('Parent', hFig, 'Units', 'normalized', 'Position', [0.28, 0.01, 0.6, 0.2], ...
                      'Title', 'Filtrage de l'' image', 'BorderType', 'etchedin');

hExtraPanelCouleur = uipanel('Parent', hExtraPanel, 'Units', 'normalized', 'Position', [0.01, 0.01, 0.4, 0.9], ...
                      'Title', 'Couleur', 'BorderType', 'etchedin');


hExtraPanelContraste = uipanel('Parent', hExtraPanel, 'Units', 'normalized', 'Position', [0.49, 0.1, 0.2, 0.75], ...
                      'Title', 'Luminosité et contraste', 'BorderType', 'etchedin');

hExtraPanelCase = uipanel('Parent', hExtraPanel, 'Units', 'normalized', 'Position', [0.732, 0.1, 0.2, 0.75], ...
                      'Title', 'Vider la case', 'BorderType', 'etchedin');


% Ajouter un bouton pour permettre à l'utilisateur de vider les cases
uicontrol('Parent', hExtraPanelCase, 'Style', 'pushbutton', 'String', 'Vider les cases', ...
          'Units', 'normalized', 'Position', [0.15, 0.55, 0.7, 0.3], 'Callback', @vider_axes, ...
          'BackgroundColor', [0.53, 0.81, 0.98], ... % Bleu ciel
          'FontName', 'Berlin Sans FB', ... % Police Berlin Sans FB
          'FontSize', 12); % Taille de police 14px



% Panneau pour le slider de Rouge
uipanel('Parent', hExtraPanelCouleur, 'Units', 'normalized', 'Position', [0.01, 0.65, 0.98, 0.3], ...
        'Title', 'Rouge', 'FontName', 'Berlin Sans FB', 'FontSize', 10, ...
        'BorderType', 'etchedin', 'BackgroundColor', [1, 0.8, 0.8]);

uicontrol('Parent', hExtraPanelCouleur, 'Style', 'slider', 'Min', 0, 'Max', 1, ...
          'Value', 1, 'Units', 'normalized', 'Position', [0.1, 0.7, 0.6, 0.1], ...
          'Tag', 'SliderRouge', 'Callback', @appliquer_couleur, 'BackgroundColor', [1, 0.6, 0.6]);

uicontrol('Parent', hExtraPanelCouleur, 'Style', 'text', 'String', '1.0', ...
          'Units', 'normalized', 'Position', [0.75, 0.7, 0.2, 0.1], ...
          'Tag', 'ValueRouge', 'FontName', 'Berlin Sans FB', 'FontSize', 10, ...
          'BackgroundColor', [1, 0.8, 0.8]);

% Panneau pour le slider de Vert
uipanel('Parent', hExtraPanelCouleur, 'Units', 'normalized', 'Position', [0.01, 0.35, 0.98, 0.3], ...
        'Title', 'Vert', 'FontName', 'Berlin Sans FB', 'FontSize', 10, ...
        'BorderType', 'etchedin', 'BackgroundColor', [0.8, 1, 0.8]);

uicontrol('Parent', hExtraPanelCouleur, 'Style', 'slider', 'Min', 0, 'Max', 1, ...
          'Value', 1, 'Units', 'normalized', 'Position', [0.1, 0.4, 0.6, 0.1], ...
          'Tag', 'SliderVert', 'Callback', @appliquer_couleur, 'BackgroundColor', [0.6, 1, 0.6]);

uicontrol('Parent', hExtraPanelCouleur, 'Style', 'text', 'String', '1.0', ...
          'Units', 'normalized', 'Position', [0.75, 0.4, 0.2, 0.1], ...
          'Tag', 'ValueVert', 'FontName', 'Berlin Sans FB', 'FontSize', 10, ...
          'BackgroundColor', [0.8, 1, 0.8]);

% Panneau pour le slider de Bleu
uipanel('Parent', hExtraPanelCouleur, 'Units', 'normalized', 'Position', [0.01, 0.05, 0.98, 0.3], ...
        'Title', 'Bleu', 'FontName', 'Berlin Sans FB', 'FontSize', 10, ...
        'BorderType', 'etchedin', 'BackgroundColor', [0.8, 0.8, 1]);

uicontrol('Parent', hExtraPanelCouleur, 'Style', 'slider', 'Min', 0, 'Max', 1, ...
          'Value', 1, 'Units', 'normalized', 'Position', [0.1, 0.1, 0.6, 0.1], ...
          'Tag', 'SliderBleu', 'Callback', @appliquer_couleur, 'BackgroundColor', [0.6, 0.6, 1]);

uicontrol('Parent', hExtraPanelCouleur, 'Style', 'text', 'String', '1.0', ...
          'Units', 'normalized', 'Position', [0.75, 0.1, 0.2, 0.1], ...
          'Tag', 'ValueBleu', 'FontName', 'Berlin Sans FB', 'FontSize', 10, ...
          'BackgroundColor', [0.8, 0.8, 1]);

% Fonction pour le couleur
function appliquer_couleur(~, ~)
    global img img_modifiee;

    % Vérifier si une image est chargée
    if isempty(img)
        errordlg('Aucune image n''a été chargée.', 'Erreur de traitement');
        return;
    end

    % Récupérer les sliders et valeurs
    sliderRouge = findobj('Tag', 'SliderRouge');
    sliderVert = findobj('Tag', 'SliderVert');
    sliderBleu = findobj('Tag', 'SliderBleu');

    valeurRouge = get(sliderRouge, 'Value');
    valeurVert = get(sliderVert, 'Value');
    valeurBleu = get(sliderBleu, 'Value');

    % Mettre à jour les textes des valeurs
    set(findobj('Tag', 'ValueRouge'), 'String', sprintf('%.2f', valeurRouge));
    set(findobj('Tag', 'ValueVert'), 'String', sprintf('%.2f', valeurVert));
    set(findobj('Tag', 'ValueBleu'), 'String', sprintf('%.2f', valeurBleu));

    % Appliquer les nouvelles valeurs à l'image
    img_colored = img;
    img_colored(:, :, 1) = img(:, :, 1) * valeurRouge; % Canal Rouge
    img_colored(:, :, 2) = img(:, :, 2) * valeurVert;  % Canal Vert
    img_colored(:, :, 3) = img(:, :, 3) * valeurBleu;  % Canal Bleu

    img_modifiee = img_colored;

    % Afficher l'image modifiée
    hAxes = findobj('Tag', 'ImageDisplayAxes');
    axes(hAxes);
    imshow(img_modifiee);
    title(hAxes, 'Image avec couleur ajustée', 'FontSize', 10, 'FontWeight', 'bold');

    % Mettre à jour l'image
    img = img_colored;
end


% Fonction pour vider l'axes
function vider_axes(~, ~)
    % Retrouver les axes par leurs Tags
    hAxesImage = findobj('Tag', 'ImageDisplayAxes');
    hAxesHistogramme = findobj('Tag', 'ImageHistogramAxes');

    % Vérifier et vider les axes tout en conservant leur style
    if ~isempty(hAxesImage) && ishandle(hAxesImage)
        cla(hAxesImage); % Effacer le contenu de l'axe de l'image
        title(hAxesImage, ''); % Supprimer le titre
        set(hAxesImage, 'Box', 'on', 'XColor', 'k', 'YColor', 'k'); % Garder les bordures et leur couleur
    end

    if ~isempty(hAxesHistogramme) && ishandle(hAxesHistogramme)
        cla(hAxesHistogramme); % Effacer le contenu de l'axe de l'histogramme
        title(hAxesHistogramme, ''); % Supprimer le titre
        set(hAxesHistogramme, 'Box', 'on', 'XColor', 'k', 'YColor', 'k'); % Garder les bordures et leur couleur
    end

    % Afficher un message de confirmation
    msgbox('Les axes ont été vidés. Vous pouvez commencer un nouveau traitement.', 'Information', 'help');
end

