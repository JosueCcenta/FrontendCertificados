import React from "react";
import { Link } from "react-router-dom";
import notFoundImage from "../../img/404/404img.png";

const Page404 = () => {
    return (
        <div className="bg-white dark:bg-gray-900">
            <div className="main mx-auto lg:flex lg:items-center">
                <div className="w-full lg:w-1/2">
                    <p className="text-sm font-medium text-blue-500 dark:text-blue-400">
                        404 error
                    </p>
                    <h1 className="mt-3 text-2xl font-semibold text-gray-800 dark:text-white md:text-3xl">
                        Page not found
                    </h1>
                    <p className="mt-4 text-gray-500 dark:text-gray-400">
                        Sorry, the page you are looking for doesn't exist. Here are some
                        helpful links:
                    </p>

                    <div className="flex items-center mt-6 gap-x-3">
                        <Link
                            to="/cert/login "
                            className="flex items-center justify-center w-1/2 px-5 py-2 text-sm text-gray-700 transition-colors duration-200 bg-white border rounded-lg gap-x-2 sm:w-auto dark:hover:bg-gray-800 dark:bg-gray-900 hover:bg-gray-100 dark:text-gray-200 dark:border-gray-700"
                        >
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                strokeWidth="1.5"
                                stroke="currentColor"
                                className="w-5 h-5 rtl:rotate-180"
                            >
                                <path
                                    strokeLinecap="round"
                                    strokeLinejoin="round"
                                    d="M6.75 15.75L3 12m0 0l3.75-3.75M3 12h18"
                                />
                            </svg>
                            <span>Go to Main Menu</span>
                        </Link>
                    </div>
                </div>

                <div className="relative w-full mt-12 lg:w-1/2 lg:mt-0">
                    <img
                        src={notFoundImage}
                        alt="image not found"
                        className="max-w-full h-auto"
                    />
                </div>
            </div>
        </div>
    );
};

export default Page404;
