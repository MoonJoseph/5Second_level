%-----------------------------------------------------------------------
% Job saved on 06-Jun-2019 16:43:59 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear all;
script_dir  ='/brain/iCAN_admin/home/zhaomuen/SPM/spm_scripts/Second_level/AMDD-CBD';
firl_dir    ='/brain/iCAN_admin/home/zhaomuen/First_level';
secl_dir    ='/brain/iCAN_admin/home/zhaomuen/Second_level/AMDD-CBD_Fullfactor_Lu';
group1_dir  ='AMDD_Lu'; group2_dir ='CBD_Lu';
[~,~,group1]=xlsread([script_dir,'/WM.xlsx'],'B:B');
[~,~,group2]=xlsread([script_dir,'/WM.xlsx'],'K:K');

fullfactor=1;
estimate  =0;
contrast  =0;


%%
if fullfactor==1
    
num1=1; scans11=[]; scans12=[]; scans13=[];
for i=1:length(group1);
    year_id=['20',group1{i,1}(1:2)]; 
    
    scans11{num1,1}=[fullfile(firl_dir,group1_dir,year_id,group1{i,1},'fmri/stats_spm12/NB/stats_spm12_swcar/con_0001.nii,1');];
    scans12{num1,1}=[fullfile(firl_dir,group1_dir,year_id,group1{i,1},'fmri/stats_spm12/NB/stats_spm12_swcar/con_0002.nii,1');];
    scans13{num1,1}=[fullfile(firl_dir,group1_dir,year_id,group1{i,1},'fmri/stats_spm12/NB/stats_spm12_swcar/con_0003.nii,1');];
   
    num1=num1+1;
end

num2=1;  scans21=[]; scans22=[]; scans23=[];
for j=1:length(group2)
   
    scans21{num2,1}=fullfile(firl_dir,group2_dir,group2{j,1},'/fmri/stats_spm12/NB/stats_spm12_swcar/con_0002.nii,1');
    scans22{num2,1}=fullfile(firl_dir,group2_dir,group2{j,1},'/fmri/stats_spm12/NB/stats_spm12_swcar/con_0002.nii,1');
    scans23{num2,1}=fullfile(firl_dir,group2_dir,group2{j,1},'/fmri/stats_spm12/NB/stats_spm12_swcar/con_0002.nii,1');

     num2=num2+1;
end


matlabbatch{1}.spm.stats.factorial_design.dir = {secl_dir};
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).name = 'work load';
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).levels = 3;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(1).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).name = 'depression';
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).levels = 2;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.fact(2).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(1).levels = [1
                                                                    1];
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(1).scans =  scans11;
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(2).levels = [1
                                                                    2];
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(2).scans =  scans12;
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(3).levels = [1
                                                                    3];
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(3).scans =  scans13;
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(4).levels = [2
                                                                    1];
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(4).scans =  scans21;
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(5).levels = [2
                                                                    2];
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(5).scans =  scans22;
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(6).levels = [2
                                                                    3];
matlabbatch{1}.spm.stats.factorial_design.des.fd.icell(6).scans =  scans23;
matlabbatch{1}.spm.stats.factorial_design.des.fd.contrasts = 1;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

spm('defaults', 'FMRI');
spm_jobman('interactive', matlabbatch(1));

end
%%
if estimate==1
    
matlabbatch{2}.spm.stats.fmri_est.spmmat = {[secl_dir,'/SPM.mat']};
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;


spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch(2));
end

%%
if contrast==1
matlabbatch{3}.spm.stats.con.spmmat = {[secl_dir,'/SPM.mat']} ;
matlabbatch{3}.spm.stats.con.consess{1}.fcon.name = 'AMDD-CBD(1-0back)';
matlabbatch{3}.spm.stats.con.consess{1}.fcon.weights = [-1 1 0 1 -1 0];
matlabbatch{3}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.fcon.name = 'AMDD-CBD(2-1back)';
matlabbatch{3}.spm.stats.con.consess{2}.fcon.weights = [0 -1 1 0 1 -1];
matlabbatch{3}.spm.stats.con.consess{2}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3}.fcon.name = 'AMDD-CBD(2-0back)';
matlabbatch{3}.spm.stats.con.consess{3}.fcon.weights = [-1 0 1 1 0 -1];
matlabbatch{3}.spm.stats.con.consess{3}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{4}.fcon.name = 'AMDD-CBD(0back)';
matlabbatch{3}.spm.stats.con.consess{4}.fcon.weights = [1 0 0 1 0 0];
matlabbatch{3}.spm.stats.con.consess{4}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{5}.fcon.name = 'AMDD-CBD(1back)';
matlabbatch{3}.spm.stats.con.consess{5}.fcon.weights = [0 1 0 0 1 0];
matlabbatch{3}.spm.stats.con.consess{5}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{6}.fcon.name = 'AMDD-CBD(2back)';
matlabbatch{3}.spm.stats.con.consess{6}.fcon.weights = [0 0 1 0 0 1];
matlabbatch{3}.spm.stats.con.consess{6}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;

spm('defaults', 'FMRI');
spm_jobman('run', matlabbatch(3));
end