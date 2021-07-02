function varargout = experimentall(varargin)
% EXPERIMENTALL MATLAB code for experimentall.fig
%      EXPERIMENTALL, by itself, creates a new EXPERIMENTALL or raises the existing
%      singleton*.
%
%      H = EXPERIMENTALL returns the handle to a new EXPERIMENTALL or the handle to
%      the existing singleton*.
%
%      EXPERIMENTALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPERIMENTALL.M with the given input arguments.
%
%      EXPERIMENTALL('Property','Value',...) creates a new EXPERIMENTALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before experimentall_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to experimentall_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help experimentall

% Last Modified by GUIDE v2.5 19-May-2021 19:32:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @experimentall_OpeningFcn, ...
                   'gui_OutputFcn',  @experimentall_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before experimentall is made visible.
function experimentall_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to experimentall (see VARARGIN)

% Choose default command line output for experimentall
handles.output = hObject;
phlena = importdata('Lena.bmp');
set(handles.pushbutton7,'CDATA',phlena);%打开lena图像
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes experimentall wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = experimentall_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in experiment1.
function experiment1_Callback(hObject, eventdata, handles)
% hObject    handle to experiment1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_1();


% --- Executes on button press in experiment2.
function experiment2_Callback(hObject, eventdata, handles)
% hObject    handle to experiment2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CUI_2();

% --- Executes on button press in experiment3.
function experiment3_Callback(hObject, eventdata, handles)
% hObject    handle to experiment3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_3();

% --- Executes on button press in experiment4.
function experiment4_Callback(hObject, eventdata, handles)
% hObject    handle to experiment4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_4();

% --- Executes on button press in experiment5.
function experiment5_Callback(hObject, eventdata, handles)
% hObject    handle to experiment5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in exitall.
function exitall_Callback(hObject, eventdata, handles)
% hObject    handle to exitall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;%退出


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)%首页展示lena图像
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
