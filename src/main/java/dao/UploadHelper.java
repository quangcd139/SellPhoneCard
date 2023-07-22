/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;
import java.io.File;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 50, // 50MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UploadHelper {
    // This function will single file or multiple files and return list of file url
    // File must be in the form-data with name "file"
    public static List<String> upload(HttpServletRequest request, String supplier) {
        String appPath = request.getServletContext().getRealPath("");
        appPath = appPath.replace('\\', '/');
        String relativePath = "upload";
        String savePath = appPath + "/" + relativePath;
        System.out.println(appPath);
        try {
            // creates the save directory if it does not exists
            java.io.File fileSaveDir = new java.io.File(savePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdir();
            }
            List<String> fileUrls = new ArrayList<>();
            for (Part part : request.getParts()) {
                String fileName = part.getSubmittedFileName();
                if (fileName != null && fileName.length() > 0) {
                    if (fileName.endsWith("png") || fileName.endsWith("jpg")) {
                        // Đây là file ảnh
                        int size = fileName.length();
                        fileName = supplier + "_logo." + fileName.substring(size - 3, size);
                        String filePath = appPath + "imageLogo/" + fileName;
                        fileUrls.add("imageLogo" + "/" + fileName);
                        part.write(filePath);
                    } else if (fileName.endsWith("xls") || fileName.endsWith("xlxs")) {
                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        String filePath = savePath + "/" + uniqueFileName;
                        fileUrls.add(relativePath + "/" + uniqueFileName);
                        part.write(filePath);
                    }
                    // unique file name with timestamp

                }
            }
            return fileUrls;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
