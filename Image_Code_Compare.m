function varargout = Image_Code_Compare(varargin)
% IMAGE_CODE_COMPARE MATLAB code for Image_Code_Compare.fig
%      IMAGE_CODE_COMPARE, by itself, creates a new IMAGE_CODE_COMPARE or raises the existing
%      singleton*.
%
%      H = IMAGE_CODE_COMPARE returns the handle to a new IMAGE_CODE_COMPARE or the handle to
%      the existing singleton*.
%
%      IMAGE_CODE_COMPARE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_CODE_COMPARE.M with the given input arguments.
%
%      IMAGE_CODE_COMPARE('Property','Value',...) creates a new IMAGE_CODE_COMPARE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Image_Code_Compare_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Image_Code_Compare_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

% Modified by hankun,zhangwensheng v1.0 11-Nov-2021 10:23:12
% Last Modified by hankun,zhangwensheng v1.0 22-Nov-2021 16:55:12


% 初始化
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Image_Code_Compare_OpeningFcn, ...
                   'gui_OutputFcn',  @Image_Code_Compare_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% --- Executes just before Image_Code_Compare is made visible.
function Image_Code_Compare_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Image_Code_Compare (see VARARGIN)

% Choose default command line output for Image_Code_Compare
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Image_Code_Compare wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Image_Code_Compare_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_bmp_load.
function pushbutton_bmp_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bmp_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile({'*.bmp'},'Load Bmp File');
image1 = im2single(imread([PathName '/' FileName]));
axes(handles.axes_signal);
imshow(image1);
filename=FileName(1:end-4);
disp(filename);

outfile='./out/result_rr.csv';
if exist(string(outfile),'file')
    disp(['Error. \n This file already exists: ',string(outfile)]);
else
    mkdir('./out');
    newCell_title={'filename','codec',...
        'filesiez','rr','mse','psnr','ssim'};
    disp(newCell_title);
    newTable = cell2table(newCell_title);
    disp(newTable)
    writetable(newTable,outfile);
end

handles.filename_rr_outfile=outfile;
% handles.fileLoaded = 1;
handles.filename = filename;
guidata(hObject, handles);


% --- Executes on button press in pushbutton_png_generate.
function pushbutton_png_generate_Callback(hObject, eventdata, handles)
% function pushbutton_genMp3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_png_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
image_in=[filename,'.bmp'];
image_out1=[filename,'.png'];
image_out2=[filename,'_png.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out1);
axes(handles.axes_image_png);
imshow(image_show);


% --- Executes on button press in pushbutton_jpeg_generate.
function pushbutton_jpeg_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_jpeg_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
image_in=[filename,'.bmp'];
image_out1=[filename,'.jpeg'];
image_out2=[filename,'_jpeg.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out1);
axes(handles.axes_image_jpeg);
imshow(image_show);


function edit_jpeg_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jpeg_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jpeg_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_jpeg_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_jpeg_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jpeg_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_jpeg_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jpeg_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jpeg_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_jpeg_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_jpeg_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jpeg_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_png_calculate.
function pushbutton_png_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_png_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.png'];
file_out2=[filename,'_png.bmp'];

image1 = im2single(imread(file_in));
image2 = im2single(imread(file_out2));
er=double(image1-image2).^2;
su = sum(sum(er)); 
si= size(image1,1)*size(image1,2)*size(image1,3);
dsi=double(si);
mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
if (mse==0)
    psnr=100;
else
    psnr = 10.0 * log10((255 * 255) / mse);
end
ssim=getMSSIM(image1,image2);
disp(mse);
disp(psnr);
disp(ssim);

% 编码方式
codec='png';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
%
% 存入文件
% codec,fs,vr,mse,psnr,ssim
% mp3,
outfile=handles.filename_rr_outfile;
newCell_title={'filename','codec',...
    'filesize','rr','mse','psnr','ssim'};
 
newCell_zhi={filename,codec,...
            filesize,'582*288',mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_png_mse,'string',mse);
set(handles.edit_png_psnr,'string',psnr);
set(handles.edit_png_ssim,'string',ssim);


function edit_png_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_png_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_png_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_png_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_png_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_png_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_png_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_png_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_png_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_png_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_png_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_png_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_jpeg_calculate.
function pushbutton_jpeg_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_jpeg_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.jpeg'];
file_out2=[filename,'_jpeg.bmp'];

image1 = im2single(imread(file_in));
image2 = im2single(imread(file_out2));
er=double(image1-image2).^2;
su = sum(sum(er)); 
si= size(image1,1)*size(image1,2)*size(image1,3);
dsi=double(si);
mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
psnr = 10.0 * log10((255 * 255) / mse);
ssim=getMSSIM(image1,image2);
disp(mse);
disp(psnr);
disp(ssim);

% 编码方式
codec='jpeg';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
%
% 存入文件
% codec,fs,vr,mse,psnr,ssim
% jpeg,
outfile=handles.filename_rr_outfile;
newCell_title={'filename','codec',...
    'filesize','rr','mse','psnr','ssim'};
 
newCell_zhi={filename,codec,...
            filesize,'582*288',mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_jpeg_mse,'string',mse);
set(handles.edit_jpeg_psnr,'string',psnr);
set(handles.edit_jpeg_ssim,'string',ssim);


% --- Executes on button press in pushbutton_wav_generateAll.
function pushbutton_wav_generateAll_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_wav_generateAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;

% bmp
image_in=[filename,'.bmp'];
image_out1=[filename,'.png'];
image_out2=[filename,'_png.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out1);
axes(handles.axes_image_png);
imshow(image_show);

% jpeg
image_in=[filename,'.bmp'];
image_out1=[filename,'.jpeg'];
image_out2=[filename,'_jpeg.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out1);
axes(handles.axes_image_jpeg);
imshow(image_show);

% jp2
image_in=[filename,'.bmp'];
image_out1=[filename,'.jp2'];
image_out2=[filename,'_jp2.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out1);
axes(handles.axes_image_jp2);
imshow(image_show);  

% webp
image_in=[filename,'.bmp'];
image_out1=[filename,'.webp'];
image_out2=[filename,'_webp.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out1);
axes(handles.axes_image_webp);
imshow(image_show);


% --- Executes on button press in pushbutton_webp_generate.
function pushbutton_webp_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webp_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
image_in=[filename,'.bmp'];
image_out1=[filename,'.webp'];
image_out2=[filename,'_webp.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out2);
axes(handles.axes_image_webp);
imshow(image_show);
% system('ffmpeg -i lena3.bmp -pix_fmt bgr8 lena3.webp');    
% system('ffmpeg -i lena3.jpeg -pix_fmt bgr24 lena3_jpeg.bmp');


function edit_webp_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webp_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webp_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_webp_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_webp_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webp_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_webp_calculate.
function pushbutton_webp_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webp_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.webp'];
file_out2=[filename,'_webp.bmp'];

image1 = im2single(imread(file_in));
image2 = im2single(imread(file_out2));
er=double(image1-image2).^2;
su = sum(sum(er)); 
si= size(image1,1)*size(image1,2)*size(image1,3);
dsi=double(si);
mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
psnr = 10.0 * log10((255 * 255) / mse);
ssim=getMSSIM(image1,image2);
disp(mse);
disp(psnr);
disp(ssim);

% 编码方式
codec='webm';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
%
% 存入文件
% codec,fs,vr,mse,psnr,ssim
outfile=handles.filename_rr_outfile;
newCell_title={'filename','codec',...
    'filesize','rr','mse','psnr','ssim'};
 
newCell_zhi={filename,codec,...
            filesize,'582*288',mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_webp_mse,'string',mse);
set(handles.edit_webp_psnr,'string',psnr);
set(handles.edit_webp_ssim,'string',ssim);


function edit_png_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_png_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_png_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_png_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_png_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_png_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_jpeg_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jpeg_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jpeg_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_jpeg_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_jpeg_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jpeg_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_webp_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webp_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webp_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_webp_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_webp_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webp_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_webp_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_webp_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_webp_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_webp_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_webp_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_webp_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_jp2_generate.
function pushbutton_jp2_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_jp2_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
image_in=[filename,'.bmp'];
image_out1=[filename,'.jp2'];
image_out2=[filename,'_jp2.bmp'];
str_out1= ['ffmpeg -i ',image_in,' -codec jpeg2000 -pix_fmt bgr8 ',image_out1];
str_out2= ['ffmpeg -i ',image_out1,' -codec bmp -pix_fmt bgr24 ',image_out2];
system(str_out1);   
system(str_out2);  

image_show=imread(image_out1);
axes(handles.axes_image_jp2);
imshow(image_show);


function edit_jp2_mse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jp2_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jp2_mse as text
%        str2double(get(hObject,'String')) returns contents of edit_jp2_mse as a double


% --- Executes during object creation, after setting all properties.
function edit_jp2_mse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jp2_mse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_jp2_psnr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jp2_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jp2_psnr as text
%        str2double(get(hObject,'String')) returns contents of edit_jp2_psnr as a double


% --- Executes during object creation, after setting all properties.
function edit_jp2_psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jp2_psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_jp2_calculate.
function pushbutton_jp2_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_jp2_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.jp2'];
file_out2=[filename,'_jp2.bmp'];

image1 = im2single(imread(file_in));
image2 = im2single(imread(file_out2));
er=double(image1-image2).^2;
su = sum(sum(er)); 
si= size(image1,1)*size(image1,2)*size(image1,3);
dsi=double(si);
mse = (su(:,:,1)+su(:,:,2)+su(:,:,3))/dsi;
psnr = 10.0 * log10((255 * 255) / mse);
ssim=getMSSIM(image1,image2);
disp(mse);
disp(psnr);
disp(ssim);

% 编码方式
codec='jpeg2000';
% 计算文件大小
[fid,errmsg]=fopen(file_out1);
disp(errmsg);
fseek(fid,0,'eof');
filesize = ftell(fid); 
disp(filesize);
% 参考值
%
% 存入文件
% codec,fs,vr,mse,psnr,ssim
% jpeg2000,
outfile=handles.filename_rr_outfile;
newCell_title={'filename','codec',...
    'filesize','rr','mse','psnr','ssim'};
 
newCell_zhi={filename,codec,...
            filesize,'582*288',mse,psnr,ssim};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);
% 写入完成。
disp('数据写入完成。');

set(handles.edit_jp2_mse,'string',mse);
set(handles.edit_jp2_psnr,'string',psnr);
set(handles.edit_jp2_ssim,'string',ssim);


function edit_jp2_ssim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_jp2_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_jp2_ssim as text
%        str2double(get(hObject,'String')) returns contents of edit_jp2_ssim as a double


% --- Executes during object creation, after setting all properties.
function edit_jp2_ssim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_jp2_ssim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton36_bmp_play.
function pushbutton36_bmp_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36_bmp_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
% file_out1=[filename,'.png'];
% file_out2=[filename,'_png.bmp'];
str_cmd=['ffplay ',file_in];
system(str_cmd); 


% --- Executes on button press in pushbutton_png_play.
function pushbutton_png_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_png_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.png'];
% file_out2=[filename,'_png.bmp'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 


% --- Executes on button press in pushbutton_jpeg_play.
function pushbutton_jpeg_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_jpeg_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.jpeg'];
% file_out2=[filename,'_jpeg.bmp'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 


% --- Executes on button press in pushbutton_jpeg2000_play.
function pushbutton_jpeg2000_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_jpeg2000_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.jp2'];
% file_out2=[filename,'_jp2.bmp'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 


% --- Executes on button press in pushbutton_webp_play.
function pushbutton_webp_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_webp_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=handles.filename;
file_in=[filename,'.bmp'];
file_out1=[filename,'.webp'];
% file_out2=[filename,'_webp.bmp'];
str_cmd=['ffplay ',file_out1];
system(str_cmd); 
